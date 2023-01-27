/*
**
** QWASAR.IO -- my_array_uniq
**
**
** @param {Integer[]} param_1
** @return {integer[]}
**
*/
function onlyUnique(value, index, self) {
    return self.indexOf(value) === index;
}
  

function my_array_uniq(unique) {
    let uniq = unique.filter(onlyUnique);
    return uniq;
};

// console.log(my_array_uniq( [1, 1, 2,7,8,8,8]))