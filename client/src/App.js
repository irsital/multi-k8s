import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import OtherPage from './OtherPage';
import Fib from './Fib';

class App extends Component {
  divStyle = {
    color: 'white',
    textDecoration: 'none'
  }
  render() {
    return (
      <Router>
        <div className="App">
          <header className="App-header">
            <h1>Fib<img src={logo} className="App-logo" alt="logo" />Calculator</h1><span>v2</span>
            <p><Link style={this.divStyle} to="/">Home</Link> | <Link style={this.divStyle} to="/otherpage">OtherPage</Link></p>
          </header>
          <div>
              <br />
              <Route exact path="/" component={Fib} />
              <br />
              <Route path="/otherpage" component={OtherPage} />
            </div>
        </div>
      </Router>
    );
  }
}

export default App;
