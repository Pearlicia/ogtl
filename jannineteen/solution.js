const canConstruct = (a, b) => {
    const len = b.length;

    for (let i = 0; i < len; i++) {
        return b.includes(a) ? true : false;
    }
}

console.log(canConstruct("man", "woman"));
console.log(canConstruct("aa", "ab"));
console.log(canConstruct("aa", "aab"));
console.log(canConstruct("a", "b"));