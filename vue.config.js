const webpack = require('webpack');

module.exports = {
  devServer: {
    port: 8080,
    host: '0.0.0.0',
    disableHostCheck: true
  },
  configureWebpack: {
    plugins: [
      new webpack.DefinePlugin({
        'process.env.NODE_OPTIONS': JSON.stringify('--openssl-legacy-provider')
      })
    ]
  }
};
