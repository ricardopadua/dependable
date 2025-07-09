ARG ELIXIR_VERSION=1.18.4
ARG OTP_VERSION=27.3
ARG ALPINE_VERSION=3.21.3
ARG BUILDER_IMAGE="hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-alpine-${ALPINE_VERSION}"
ARG RUNNER_IMAGE="alpine:${ALPINE_VERSION}"

FROM ${BUILDER_IMAGE} AS builder

RUN apk -U upgrade && apk --no-cache add \
  ca-certificates \
  git \
  make \
  automake \
  autoconf \
  musl \
  build-base \
  curl \
  openssl \
  ncurses-libs \
  libc-dev \
  libstdc++ \
  inotify-tools \
  postgresql-client \
  neovim bash \
  && update-ca-certificates --fresh

ARG MIX_ENV
ARG API_PORT
ARG EPMD_PORT
ARG DIST_ERL_PORT_RANGE
ARG APP_NAME
ARG APP_VERSION
ARG SHA

ENV MIX_ENV=${MIX_ENV:-prod}
ENV API_PORT=${API_PORT:-4000}
ENV EPMD_PORT=${EPMD_PORT:-4369}
ENV DIST_ERL_PORT_RANGE=${DIST_ERL_PORT_RANGE:-9100-9114}
ENV APP_NAME=${APP_NAME:-my_app}
ENV APP_VERSION=${APP_VERSION:-0.1.0}
ENV SHA=${SHA:-missing-sha}

COPY mix.exs mix.lock ./
COPY  config/config.exs config/runtime.exs config/${MIX_ENV}.exs config/
COPY lib lib
COPY rel rel

RUN mix local.rebar --force && mix local.hex --force
RUN mix archive.install hex phx_new --force
RUN mix deps.get --only $MIX_ENV
RUN mix deps.compile
RUN mix compile
RUN mix release

EXPOSE ${API_PORT}
EXPOSE ${EPMD_PORT}
EXPOSE ${DIST_ERL_PORT_RANGE}

FROM ${RUNNER_IMAGE} AS runner

RUN apk add --no-cache libstdc++ openssl ncurses-libs

ARG MIX_ENV
ARG API_PORT
ARG EPMD_PORT
ARG DIST_ERL_PORT_RANGE
ARG APP_NAME
ARG APP_VERSION
ARG SHA

LABEL org.opencontainers.image.version="${APP_VERSION}" \
      org.opencontainers.image.revision="${SHA}" \
      org.opencontainers.image.title="${APP_NAME}"

ENV TZ="America/Sao_Paulo"
ENV MIX_ENV=${MIX_ENV:-prod}
ENV API_PORT=${API_PORT:-4000}
ENV EPMD_PORT=${EPMD_PORT:-4369}
ENV DIST_ERL_PORT_RANGE=${DIST_ERL_PORT_RANGE:-9100-9114}
ENV APP_NAME=${APP_NAME:-my_app}
ENV APP_VERSION=${APP_VERSION:-0.1.0}
ENV SHA=${SHA:-missing-sha}

EXPOSE ${EPMD_PORT}
EXPOSE ${DIST_ERL_PORT_RANGE}

COPY --from=builder --chown=nobody:nogroup _build/${MIX_ENV}/rel/${APP_NAME} .

USER nobody:nogroup

CMD ["/bin/server"]
