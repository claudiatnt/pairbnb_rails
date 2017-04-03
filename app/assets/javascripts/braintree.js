// the first line is to allow the js code to run after the document is ready


$(document).ready(function(){
  // becuz document.ready will work everytime the document is ready, if i m just running datepicker instead of this form, my authorization is not defined, so it wont run the whole bunch of code below
  // line below means if authorization is not defined then it will run the code for date picker, if authorization is defined then it will run the braintree code below. This is to make sure all the js codes work
  if(typeof authorization != 'undefined'){
    var form = document.querySelector('#cardForm');
    var submit = document.querySelector("#submit-payment-btn");
    braintree.client.create({
      // Replace this with your own authorization.
      authorization: authorization
    }, function (clientErr, clientInstance) {
      if (clientErr) {
        // Handle error in client creation
        return;
      }

      braintree.hostedFields.create({
        client: clientInstance,
        styles: {
          'input': {
            'font-size': '10pt'
          },
          'input.invalid': {
            'color': 'red'
          },
          'input.valid': {
            'color': 'green'
          }
        },
        fields: {
          number: {
            selector: '#card-number',
            placeholder: '4111 1111 1111 1111'
          },
          cvv: {
            selector: '#cvv',
            placeholder: '123'
          },
          expirationDate: {
            selector: '#expiration-date',
            placeholder: '10/2019'
          }
        }
      }, function (hostedFieldsErr, hostedFieldsInstance) {
        if (hostedFieldsErr) {
          // Handle error in Hosted Fields creation
          return;
        }

        submit.removeAttribute('disabled');

        form.addEventListener('submit', function (event) {
          event.preventDefault();

          hostedFieldsInstance.tokenize(function (tokenizeErr, payload) {
            if (tokenizeErr) {
              // Handle error in Hosted Fields tokenization
              return;
            }

            // Put `payload.nonce` into the `payment_method_nonce` input, and then
            // submit the form. Alternatively, you could send the nonce to your server
            // with AJAX.
            document.querySelector('input[name="checkout_form[payment_method_nonce]"]').value = payload.nonce;
            form.submit();
          });
        }, false);
      });
    });
  }
});
