/**
 * 🛡️ درع زايد للأمن السيبراني - Webpack Configuration
 * Zayed Shield Cybersecurity - Build Configuration
 */

const path = require('path');
const TerserPlugin = require('terser-webpack-plugin');

module.exports = {
  entry: './index.js',
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'zayed-shield.min.js',
    library: {
      name: 'ZayedCyberShield',
      type: 'umd',
      export: 'default',
    },
    globalObject: 'this',
    clean: true,
  },
  mode: 'production',
  target: ['web', 'es5'],
  devtool: 'source-map',
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: [
              ['@babel/preset-env', {
                // Using browserslist configuration
                targets: '> 1%, last 2 versions, not dead',
              }],
            ],
          },
        },
      },
    ],
  },
  optimization: {
    minimize: true,
    minimizer: [
      new TerserPlugin({
        terserOptions: {
          format: {
            comments: /^!/,
          },
          compress: {
            drop_console: false,
            drop_debugger: true,
          },
          mangle: {
            reserved: ['ZayedCyberShield', 'CyberShieldProtection'],
          },
        },
        extractComments: false,
      }),
    ],
  },
  resolve: {
    extensions: ['.js'],
  },
  performance: {
    hints: 'warning',
    maxEntrypointSize: 512000,
    maxAssetSize: 512000,
  },
};
