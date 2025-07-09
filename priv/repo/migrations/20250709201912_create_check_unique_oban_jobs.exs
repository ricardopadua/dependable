defmodule MyApp.Repo.Migrations.CreateCheckUniqueObanJobs do
  use Ecto.Migration

  def up do
    execute """
      CREATE OR REPLACE FUNCTION check_unique_oban_jobs()
      RETURNS TRIGGER AS $$
      BEGIN
          IF EXISTS (
              SELECT 1 FROM oban_jobs
              WHERE worker = NEW.worker
              AND args = NEW.args
              AND state in ('scheduled', 'available', 'executing', 'retryable', 'completed', 'discarded', 'cancelled')
          ) THEN
              RAISE NOTICE 'A job with the same args already exists for this worker.';
               IF TG_OP = 'INSERT' THEN
                  RETURN NULL;
              ELSE
                  RETURN OLD;
              END IF;
          END IF;

          RETURN NEW;
      END;
      $$ LANGUAGE plpgsql;
    """

    execute """
      CREATE TRIGGER check_unique_oban_jobs_trigger
      BEFORE INSERT ON oban_jobs
      FOR EACH ROW
      EXECUTE FUNCTION check_unique_oban_jobs();
    """
  end

  def down do
    execute "DROP TRIGGER check_unique_oban_jobs_trigger ON oban_jobs;"
    execute "DROP FUNCTION check_unique_oban_jobs();"
  end
end
