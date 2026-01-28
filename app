import { useState, useEffect } from 'react';
import './App.css';

// ייבוא הקומפוננטות 
// import TaskInput from './components/TaskInput';
// import TaskList from './components/TaskList';
// import TaskFilter from './components/TaskFilter';

function App() {
  // 1. State לניהול רשימת המשימות
  const [tasks, setTasks] = useState(() => {
    // טעינה ראשונית מ-LocalStorage
    const savedTasks = localStorage.getItem('tasks');
    return savedTasks ? JSON.parse(savedTasks) : [];
  });

  // 2. State לניהול הסינון הנוכחי (All, Active, Completed)
  const [filter, setFilter] = useState('all');

  // 3. שמירה ל-LocalStorage בכל פעם שהרשימה משתנה
  useEffect(() => {
    localStorage.setItem('tasks', JSON.stringify(tasks));
  }, [tasks]);

  // --- פונקציות לניהול משימות ---

  const addTask = (text) => {
    const newTask = {
      id: crypto.randomUUID(), // מזהה ייחודי כפי שנדרש
      text,
      isCompleted: false
    };
    setTasks([...tasks, newTask]);
  };

  const toggleTask = (id) => {
    setTasks(tasks.map(task => 
      task.id === id ? { ...task, isCompleted: !task.isCompleted } : task
    ));
  };

  const deleteTask = (id) => {
    setTasks(tasks.filter(task => task.id !== id));
  };

  const editTask = (id, newText) => {
    setTasks(tasks.map(task => 
      task.id === id ? { ...task, text: newText } : task
    ));
  };

  // 4. לוגיקת סינון המשימות להצגה
  const filteredTasks = tasks.filter(task => {
    if (filter === 'active') return !task.isCompleted;
    if (filter === 'completed') return task.isCompleted;
    return true; // 'all'
  });

  // משימות שנותרו (למונה המשימות)
  const activeTasksCount = tasks.filter(t => !t.isCompleted).length;

  return (
    <div className="app-container">
      <h1>מנהל המשימות שלי</h1>
      
      {/* כאן יבואו הקומפוננטות שנבנה */}
      {/* <TaskInput onAdd={addTask} /> */}
      
      {/* <TaskFilter currentFilter={filter} setFilter={setFilter} /> */}
      
      <div className="stats">
        משימות לביצוע: {activeTasksCount}
      </div>

      {/* <TaskList 
        tasks={filteredTasks} 
        onToggle={toggleTask} 
        onDelete={deleteTask} 
        onEdit={editTask} 
      /> */}
      
      <p style={{fontSize: '0.8rem', color: 'gray'}}>
      </p>
    </div>
  );
}

export default App;
