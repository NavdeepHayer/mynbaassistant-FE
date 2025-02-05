const webpack = require('webpack');

module.exports = {
  devServer: {
    port: 8080,
    host: '0.0.0.0',
    allowedHosts: 'all',
  },
  configureWebpack: {
    plugins: [
      new webpack.DefinePlugin({
        'process.env.NODE_OPTIONS': JSON.stringify('--openssl-legacy-provider')
      })
    ],
    optimization: {
      minimize: true,
      minimizer: [
        new (require('terser-webpack-plugin'))({
          terserOptions: {
            compress: {
              drop_console: true
            }
          }
        })
      ]
    }
  }
};
