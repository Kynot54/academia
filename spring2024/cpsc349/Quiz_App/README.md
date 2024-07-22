# Quiz_App
Project 1 - Quiz App for CPSC 349

## Project Setup / Configuration

- Uses the Node Package Manager (npm) for usage see [NodeJS](https://nodejs.org/en/download) to install; if using Linux I personally recommend Node Version Manager by [nvm.sh](https://github.com/nvm-sh/nvm) to install the latest version by following their installation instructions and then running:

    nvm install [Latest LTS Version] # Currently, 20.12.0 at the time of writing this README

- Confirm nvm works by running ```nvm -v``` to get the current version number. For assitance, consult the documentation, or possibly close and re-open terminal to confirm nvm is installed. Could also run ```source ~/.zshrc or ~/.bashrc``` to reload the Z-Shell or Bash Shell depending on what your Linux Distribution uses. 

### Install Webpack Dependencies

    npm i --save-dev webpack webpack-cli webpack-dev-server html-webpack-plugin

### Install Bootstrap 5

    npm i --save bootstrap @popperjs/core

### Install Addtional Dependencies with...

    npm i --save-dev autoprefixer css-loader postcss-loader sass sass-loader style-loader

Using the Fetch API supported on Most Modern Browsers; although, locally it has to be install seperately, see [MDN Docs](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch) for details...

    npm install whatwg-fetch
 
Due to changing the Project Structure with Webpack I had to install this library to accomodate for the Images and JSON Data

    npm install copy-webpack-plugin --save-dev

### Running the Project

Now the project should all be set to go. Run:

    npm start

the project should now be running on the ```localhost``` at port ```8080``` i.e. 

    http://localhost:8080/
