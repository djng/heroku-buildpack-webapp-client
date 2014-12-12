var available = process.env.MEM_AVAILABLE;
var allowance = process.env.MEM_ALLOWANCE;
var count = process.env.PROCESS_COUNT;

console.log([available, allowance, count].join(' '));
