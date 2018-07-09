import React, { Component } from 'react';
import EmailField from './components/EmailField';

import { IsValidEmail, GetPossibleEmails, SetObjectClass } from './utils/helper';
import { API_KEY, API_SERVICE, STATUS_MESSAGES, POPULAR_DOMAINS } from './utils/constants';

import './App.css';

let activePrompt = -1;

class App extends Component {
  state = {
    email: '',
    prompts: [],
    status: 'default'
  };
  render() {
    return (
      <div className="App">
        <header>
          <h1>Verify your email address</h1>
        </header>
        <section>
          <form
            className={this.state.status}

            onChange={this.handleChange}
            onSubmit={this.handleSubmit}
            onKeyDown={this.handleKeyPress}>

            <small className="status">{STATUS_MESSAGES[this.state.status]}</small>
            <small className="suggestion" onClick={this.handleSelect}>{this.state.suggestion}</small>

            <EmailField email={this.state.email} />

            <ul className="autoComplete">
              {this.state.prompts.map(prompt =>
                <li className={prompt.class} key={prompt.id} onClick={this.handleSelect}>{prompt.text}</li>
              )}
            </ul>

          </form>
        </section>
        <footer></footer>
      </div>
    );
  }

  handleSubmit = (e) => e.preventDefault();

  /* user clicks autoComplete item */
  handleSelect = (e) => this.verifyEmail(e.target.innerHTML);

  /* user types in the field, watch for up and down arrows and set and reset prompt data if necessary */
  handleKeyPress = (e) => {
    if (this.state.prompts.length>0) {
      if (e.keyCode===13 && activePrompt > -1) {
        this.verifyEmail(this.state.prompts[activePrompt].text);
      }
      else if (e.keyCode===38 && activePrompt > -1) {
        activePrompt--;
        this.setState({prompts:SetObjectClass(this.state.prompts,activePrompt,'active',true)});
      }
      else if (e.keyCode===40 && activePrompt<this.state.prompts.length-1) {
        activePrompt++;
        this.setState({prompts:SetObjectClass(this.state.prompts,activePrompt,'active',true)});
      }
    }
  }

  /* user types or pastes into field */
  handleChange = (e) => {
    if (e.target.value==='') {
      this.setState({
        prompts:[],
        activePrompt:-1,
        status:'default',
        email:e.target.value
      });
      activePrompt=-1;
    }
    else this.verifyEmail(e.target.value);
  }

  /* check for valid format before making api call which checks that email address exists */
  verifyEmail = async (emailString) => {
    if (IsValidEmail(emailString)) {
      this.setState({
        prompts:[],
        status:'valid',
        email:emailString
      });
      activePrompt=-1;
      /* use cors.io during local development */
      const promise = await fetch(`https://cors.io/?${API_SERVICE}email=${emailString}&apikey=${API_KEY}`)
      .catch(error => console.log(`error:  ${error}`));
      const json = await promise.json();
      if (json.did_you_mean) this.setState({status:'did_you_mean',suggestion:json.did_you_mean});
      else this.setState({status:json.result,suggestion:''});
    }
    else {
      this.setState({
        status:'invalid',
        email: emailString,
        prompts: GetPossibleEmails(emailString, POPULAR_DOMAINS)
      });
      activePrompt=-1;
    }
  }
}

export default App;
