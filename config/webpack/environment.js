const { environment } = require('@rails/webpacker')
const webpack = require('webpack')
// const datatables = require('./loaders/datatables')

environment.plugins.append(
    'Provide',
    new webpack.ProvidePlugin({
        $: 'jquery',
        // jQuery: 'jquery',
        jQuery: 'jquery/src/jquery',
        Popper: ['popper.js', 'default'],
    })
);
module.exports = environment
