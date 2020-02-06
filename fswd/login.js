
const actions= {
    rememberme:(user,password)=>{
        localStorage.setItem('email',user);
        localStorage.setItem('password',password);
        return true;
    },
    login:(user,password)=>{
        fetch('/fswd/login.php', {
            method: 'POST', 
            body: JSON.stringify({
                user:user,
                password:password
            }),
            headers:{'Content-Type': 'application/json'}
            }).then(res => res.json())
            .then(res=> {
                // console.log(res);
                if(res.isValid){
                    if(getBy.id('rememberme').checked){
                        actions.rememberme(user,password)
                    }
                    document.location.href  = '/fswd/knowledgecity-test-app.html';
                }else{
                    alert("Unvalid User or Password");
                    actions.clearPassword();
                }
            })
            .catch(error => console.error('Error:', error));
    },
    clearPassword:()=> setValueBy.id('password','')
};

getBy.id('login-button').onclick=()=> actions.login(getBy.id('email').value,getBy.id('password').value);
setValueBy.id('email',localStorage.getItem('email')? localStorage.getItem('email'):'');
setValueBy.id('password',localStorage.getItem('password')? localStorage.getItem('password'):'');
getBy.id('rememberme').checked = localStorage.getItem('email')?true:false;