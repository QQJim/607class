/*
  # Initial Schema Setup for Class Website

  1. New Tables
    - profiles
      - id (uuid, primary key)
      - username (text, unique)
      - role (text)
      - created_at (timestamp)
    
    - announcements
      - id (uuid, primary key)
      - title (text)
      - content (text)
      - created_at (timestamp)
      - created_by (uuid, references profiles)
    
    - assignments
      - id (uuid, primary key)
      - title (text)
      - description (text)
      - due_date (timestamp)
      - created_at (timestamp)
      - created_by (uuid, references profiles)
    
    - messages
      - id (uuid, primary key)
      - content (text)
      - created_at (timestamp)
      - user_id (uuid, references profiles)
    
    - photos
      - id (uuid, primary key)
      - url (text)
      - title (text)
      - description (text)
      - created_at (timestamp)
      - uploaded_by (uuid, references profiles)

  2. Security
    - Enable RLS on all tables
    - Add policies for authenticated users
*/

-- Create profiles table
CREATE TABLE IF NOT EXISTS profiles (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  username text UNIQUE NOT NULL,
  role text NOT NULL CHECK (role IN ('teacher', 'student')),
  created_at timestamptz DEFAULT now()
);

-- Create announcements table
CREATE TABLE IF NOT EXISTS announcements (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  content text NOT NULL,
  created_at timestamptz DEFAULT now(),
  created_by uuid REFERENCES profiles(id) NOT NULL
);

-- Create assignments table
CREATE TABLE IF NOT EXISTS assignments (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  description text NOT NULL,
  due_date timestamptz NOT NULL,
  created_at timestamptz DEFAULT now(),
  created_by uuid REFERENCES profiles(id) NOT NULL
);

-- Create messages table
CREATE TABLE IF NOT EXISTS messages (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  content text NOT NULL,
  created_at timestamptz DEFAULT now(),
  user_id uuid REFERENCES profiles(id) NOT NULL
);

-- Create photos table
CREATE TABLE IF NOT EXISTS photos (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  url text NOT NULL,
  title text NOT NULL,
  description text,
  created_at timestamptz DEFAULT now(),
  uploaded_by uuid REFERENCES profiles(id) NOT NULL
);

-- Enable Row Level Security
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE announcements ENABLE ROW LEVEL SECURITY;
ALTER TABLE assignments ENABLE ROW LEVEL SECURITY;
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE photos ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Profiles are viewable by authenticated users"
  ON profiles FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Announcements are viewable by authenticated users"
  ON announcements FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Teachers can create announcements"
  ON announcements FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role = 'teacher'
    )
  );

CREATE POLICY "Assignments are viewable by authenticated users"
  ON assignments FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Teachers can create assignments"
  ON assignments FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role = 'teacher'
    )
  );

CREATE POLICY "Messages are viewable by authenticated users"
  ON messages FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Authenticated users can create messages"
  ON messages FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Photos are viewable by authenticated users"
  ON photos FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Teachers can upload photos"
  ON photos FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role = 'teacher'
    )
  );