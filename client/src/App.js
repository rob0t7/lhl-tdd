import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';


class App extends Component {
  constructor(props) {
    super(props)
    this.state = {breweries: []}
  }

  componentDidMount() {
    fetch("/api/breweries")
      .then(resp => {return resp.json() })
      .then(json => {
        this.setState({breweries: json})
      })
  }
  render() {
    return (
      <div className="App">
        <ul>
          { this.state.breweries.map( brewery =>  <li key={brewery.id}>{brewery.name}</li> )}
        </ul>
      </div>
    );
  }
}

export default App;
