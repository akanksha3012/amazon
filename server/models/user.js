const mongoose = require ('mongoose');
const { productSchema } = require('./product');

const userSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^(([^<>()[\]\.,;:\s@"]+(\.[^<>()[\]\.,;:\s@"]+)*)|(".+"))@(([^<>()[\]\.,;:\s@"]+\.)+[^<>()[\]\.,;:\s@"]{2,})$/i;
                return value.match(re);
            },
            message: 'Please enter a valid email address.',
        },
    },
    password: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: function(value) {
                return value.length > 6; // Ensure password is longer than 6 characters
            },
            message: 'Password must be longer than 6 characters.',
        },
    },
    address: {
        type: String,
        default: '',
    },
    type: {
        type: String,
        default: 'user',
    },
    cart: [{
        product: productSchema,
        quantity: {
            type:Number,
            required:true,
        }
    }],

});

const User = mongoose.model('User', userSchema);
module.exports = User;