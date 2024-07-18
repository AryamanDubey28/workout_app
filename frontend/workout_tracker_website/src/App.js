import './App.css';

// Entire Application exists here -> Everything here is put in root HTML div
// Like the main function, uses JSX (mixes JS with HTML)
function App() {
  
  return (
    <div className="App">
      <GetDetailsComponent last_name = "Surname"/> {/*calling component with custom argument*/}
      <GetDetailsComponent last_name = "Surname 2"/>
    </div>
  );
}

// Components have to start with capitals
const GetDetailsComponent = (props) => {
  return <h3>{props.last_name}</h3>;
};

export default App;
