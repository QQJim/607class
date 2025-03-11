import React from 'react';
import { Outlet, Link, useNavigate } from 'react-router-dom';
import { useAuthStore } from '../store/authStore';
import { 
  Home, 
  BookOpen, 
  Camera, 
  MessageSquare, 
  Calendar as CalendarIcon,
  Users,
  LogOut
} from 'lucide-react';
import { supabase } from '../lib/supabase';

function Layout() {
  const { user, setUser } = useAuthStore();
  const navigate = useNavigate();

  const handleLogout = async () => {
    await supabase.auth.signOut();
    setUser(null);
    navigate('/login');
  };

  return (
    <div className="min-h-screen bg-gray-50">
      <nav className="bg-indigo-600 text-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center justify-between h-16">
            <div className="flex items-center">
              <span className="text-xl font-bold">607班級網站</span>
              <div className="hidden md:block ml-10">
                <div className="flex items-baseline space-x-4">
                  <Link to="/" className="px-3 py-2 rounded-md hover:bg-indigo-500">
                    <Home className="inline-block w-5 h-5 mr-1" />
                    首頁
                  </Link>
                  <Link to="/assignments" className="px-3 py-2 rounded-md hover:bg-indigo-500">
                    <BookOpen className="inline-block w-5 h-5 mr-1" />
                    作業
                  </Link>
                  <Link to="/photos" className="px-3 py-2 rounded-md hover:bg-indigo-500">
                    <Camera className="inline-block w-5 h-5 mr-1" />
                    相簿
                  </Link>
                  <Link to="/messages" className="px-3 py-2 rounded-md hover:bg-indigo-500">
                    <MessageSquare className="inline-block w-5 h-5 mr-1" />
                    留言板
                  </Link>
                  <Link to="/calendar" className="px-3 py-2 rounded-md hover:bg-indigo-500">
                    <CalendarIcon className="inline-block w-5 h-5 mr-1" />
                    行事曆
                  </Link>
                  {user?.role === 'teacher' && (
                    <Link to="/students" className="px-3 py-2 rounded-md hover:bg-indigo-500">
                      <Users className="inline-block w-5 h-5 mr-1" />
                      學生名單
                    </Link>
                  )}
                </div>
              </div>
            </div>
            <div className="flex items-center">
              <span className="mr-4">{user?.username}</span>
              <button
                onClick={handleLogout}
                className="flex items-center px-3 py-2 rounded-md hover:bg-indigo-500"
              >
                <LogOut className="w-5 h-5 mr-1" />
                登出
              </button>
            </div>
          </div>
        </div>
      </nav>

      <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <Outlet />
      </main>
    </div>
  );
}

export default Layout;