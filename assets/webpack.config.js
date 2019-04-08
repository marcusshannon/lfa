const path = require("path");
const CopyWebpackPlugin = require("copy-webpack-plugin");

module.exports = (env, options) => ({
  entry: {
    index: "./js/index.js"
  },
  output: {
    filename: "[name].bundle.js",
    chunkFilename: "[name].chunk.js",
    path: path.resolve(__dirname, "../priv/static/js"),
    publicPath: "/js/"
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader"
        }
      }
    ]
  },
  plugins: [new CopyWebpackPlugin([{ from: "static/", to: "../" }])]
});
