import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { Toaster } from 'react-hot-toast';
import Layout from './components/Layout';
import Home from './pages/Home';
import Login from './pages/Login';
import Register from './pages/Register';
import Assignments from './pages/Assignments';
import PhotoAlbum from './pages/PhotoAlbum';
import MessageBoard from './pages/MessageBoard';
import Calendar from './pages/Calendar';
import Students from './pages/Students';

function App() {
  return (
    <Router>
      <Toaster position="top-right" />
      <Routes>
        <Route path="/login" element={<Login />} />
        <Route path="/register" element={<Register />} />
        <Route element={<Layout />}>
          <Route path="/" element={<Home />} />
          <Route path="/assignments" element={<Assignments />} />
          <Route path="/photos" element={<PhotoAlbum />} />
          <Route path="/messages" element={<MessageBoard />} />
          <Route path="/calendar" element={<Calendar />} />
          <Route path="/students" element={<Students />} />
        </Route>
      </Routes>
    </Router>
  );
}

export default App;