/*
  # Create elite_winners table

  1. New Tables
    - `elite_winners`
      - `id` (uuid, primary key)
      - `guide_id` (integer, references original guide)
      - `name` (text, winner name)
      - `department` (text, winner department)
      - `supervisor` (text, winner supervisor)
      - `timestamp` (timestamptz, original win timestamp)
      - `elite_timestamp` (timestamptz, elite audit win timestamp)
      - `chat_ids` (text[], original win chat IDs)
      - `elite_chat_ids` (text[], elite audit chat IDs)
      - `created_at` (timestamptz, record creation time)

  2. Security
    - Enable RLS on `elite_winners` table
    - Add policies for public access (view, insert, delete)

  3. Performance
    - Add indexes for common queries
*/

CREATE TABLE IF NOT EXISTS elite_winners (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  guide_id integer NOT NULL,
  name text NOT NULL,
  department text NOT NULL,
  supervisor text NOT NULL,
  timestamp timestamptz NOT NULL,
  elite_timestamp timestamptz NOT NULL,
  chat_ids text[] DEFAULT '{}',
  elite_chat_ids text[] DEFAULT '{}',
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

-- Add indexes for better performance
CREATE INDEX IF NOT EXISTS elite_winners_created_at_idx ON elite_winners (created_at DESC);
CREATE INDEX IF NOT EXISTS elite_winners_department_idx ON elite_winners (department);
CREATE INDEX IF NOT EXISTS elite_winners_elite_timestamp_idx ON elite_winners (elite_timestamp DESC);
CREATE INDEX IF NOT EXISTS elite_winners_guide_id_idx ON elite_winners (guide_id);