import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    {/*root puts all code into the single HTML file we have (index.html) and puts it in the div with id root*/}
    <App />
    {/* App represents all the code we have -> similar to main function */}
  </React.StrictMode>
);

