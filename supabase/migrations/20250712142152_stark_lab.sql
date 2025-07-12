/*
  # Create elite_winners table

  1. New Tables
    - `elite_winners`
      - `id` (uuid, primary key)
      - `guide_id` (integer, not null)
      - `name` (text, not null)
      - `department` (text, not null)
      - `supervisor` (text, not null)
      - `timestamp` (timestamptz, not null) - original winner timestamp
      - `elite_timestamp` (timestamptz, not null) - elite selection timestamp
      - `chat_ids` (text array, default empty array) - original chat IDs
      - `elite_chat_ids` (text array, default empty array) - elite chat IDs
      - `created_at` (timestamptz, default now())

  2. Security
    - Enable RLS on `elite_winners` table
    - Add policies for public access to view, insert, and delete elite winners

  3. Indexes
    - Index on created_at for performance
    - Index on department for filtering
    - Index on elite_timestamp for sorting
*/

CREATE TABLE IF NOT EXISTS elite_winners (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  guide_id integer NOT NULL,
  name text NOT NULL,
  department text NOT NULL,
  supervisor text NOT NULL,
  timestamp timestamptz NOT NULL,
  elite_timestamp timestamptz NOT NULL,
  chat_ids text[] DEFAULT '{}'::text[],
  elite_chat_ids text[] DEFAULT '{}'::text[],
  created_at timestamptz DEFAULT now()
);

ALTER TABLE elite_winners ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can view elite winners"
  ON elite_winners
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Anyone can add elite winners"
  ON elite_winners
  FOR INSERT
  TO public
  WITH CHECK (true);

CREATE POLICY "Anyone can delete elite winners"
  ON elite_winners
  FOR DELETE
  TO public
  USING (true);

CREATE INDEX IF NOT EXISTS elite_winners_created_at_idx ON elite_winners (created_at DESC);
CREATE INDEX IF NOT EXISTS elite_winners_department_idx ON elite_winners (department);
CREATE INDEX IF NOT EXISTS elite_winners_elite_timestamp_idx ON elite_winners (elite_timestamp DESC);