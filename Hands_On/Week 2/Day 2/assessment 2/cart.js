// cartModule.js

// calculation function
export const calculateInvoice = (cart) => {
    let total = 0;

    const lines = cart.map(item => {
        const subtotal = item.price * item.qty;
        total += subtotal;
        return `${item.name} - ₹${item.price} x ${item.qty} = ₹${subtotal}`;
    });

    return `
---- Invoice ----
${lines.join("\n")}
Total: ₹${total}
`;
};