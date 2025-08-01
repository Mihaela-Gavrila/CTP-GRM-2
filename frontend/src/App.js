import React from 'react';

function App() {
  return React.createElement('div', { style: { textAlign: 'center', padding: '50px' } },
    React.createElement('h1', null, 'GRM 2.0 - Sistem ERP'),
    React.createElement('p', null, '✅ Backend: Spring Boot + PostgreSQL'),
    React.createElement('p', null, '✅ Frontend: React + Material-UI'),
    React.createElement('p', null, '✅ Docker: Containerizare completă'),
    React.createElement('h2', { style: { color: '#1976d2', marginTop: '30px' } }, '🚀 Aplicația este gata să ruleze!')
  );
}

export default App;
