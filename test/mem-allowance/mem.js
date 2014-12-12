var available = process.env.MEM_AVAILABLE;
var allowance = process.env.PROCESS_MEM;
var count = process.env.PROCESS_COUNT;

console.log([available, allowance, count].join(' '));
