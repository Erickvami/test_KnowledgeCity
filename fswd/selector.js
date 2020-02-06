const getBy = {
    id: id=> document.getElementById(id),
    class:classname=> document.getElementsByClassName(classname),
    name: name=> document.getElementsByName(name),
    tag: tag=> document.getElementsByTagName(tag)
}
const setValueBy = {
    id: (id,value)=> document.getElementById(id).value = value,
    class:(classname,value)=> document.getElementsByClassName(classname)[0].value = value,
    name: (name,value)=> document.getElementsByName(name).value = value,
    tag: (tag,value)=> document.getElementsByTagName(tag)[0].value = value
}