export type UserRole = 'teacher' | 'student';

export interface User {
  id: string;
  username: string;
  role: UserRole;
  created_at: string;
}

export interface Announcement {
  id: string;
  title: string;
  content: string;
  created_at: string;
  created_by: string;
}

export interface Assignment {
  id: string;
  title: string;
  description: string;
  due_date: string;
  created_at: string;
  created_by: string;
}

export interface Message {
  id: string;
  content: string;
  created_at: string;
  user_id: string;
  username: string;
}

export interface Photo {
  id: string;
  url: string;
  title: string;
  description: string;
  created_at: string;
  uploaded_by: string;
}