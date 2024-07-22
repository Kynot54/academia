'use strict'

const path = require('path')
const autoprefixer = require('autoprefixer')
const HtmlWebpackPlugin = require('html-webpack-plugin')
const miniCssExtractPlugin = require('mini-css-extract-plugin')
const CopyPlugin = require('copy-webpack-plugin');


module.exports = {
  mode: 'development',
  entry: {
    index: './src/js/main.js',
    quiz: './src/js/quiz.js'
  },
  output: {
    filename: 'js/[name].[contenthash].js',
    path: path.resolve(__dirname, 'dist')
  },
  devServer: {
    static: path.resolve(__dirname, 'dist'),
    port: 8080,
    compress: true,
    hot: true
  },
  plugins: [
    new HtmlWebpackPlugin({ 
      template: './src/pages/index.html',
      filename: 'index.html',
      chucks: ['index'] 
    }),
    new HtmlWebpackPlugin({ 
      template: './src/pages/quiz.html',
      filename: 'quiz.html',
      chucks: ['quiz'],
      inject: true 
    }),
    new miniCssExtractPlugin(),
    new CopyPlugin({
      patterns: [
        { from: './src/data', to: 'data' },
      ],
    }),
    new CopyPlugin({
        patterns: [
          { from: './src/images', to: 'images' },
        ],
    }),
  ],
  module: {
    rules: [
      {
        test: /\.(png|svg|jpg|jpeg|gif)$/i,
        type: 'asset/resource',
        generator:{
          filename: 'images/[path][name][ext][query]'
        }
      },
      {        
        test: /\.(scss)$/,
        use: [
          {
            // Extracts CSS for each JS file that includes CSS
            loader: miniCssExtractPlugin.loader
          },
          {
            loader: 'css-loader'
          },
          {
            loader: 'postcss-loader',
            options: {
              postcssOptions: {
                plugins: [
                  autoprefixer
                ]
              }
            }
          },
          {
            loader: 'sass-loader'
          }
        ]
      }
    ]
  }
}