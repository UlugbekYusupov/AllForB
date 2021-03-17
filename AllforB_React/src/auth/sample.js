// 삭제
// const RemoveValue = async () => {
//   try {
//     await AsyncStorage.removeItem('UserId')
//   } catch(e) {
//     console.log(e)
//   }
// }

// 복수 출력 multiGet
// getLogins = async () => {

//   let values
//   try {
//     values = await AsyncStorage.multiGet(['UserId', 'LoginToken'])
    
//   } catch(e) {
//     console.log(e);
//   }
//   console.log(JSON.stringify(values))
// }

// 출력
// AsyncStorage.getItem('UserId', (err, result) => {
//   console.log("UserID :  ", result); 
// });


    // const foundUser = Users.filter( item => {
    //   return accountId == item.username && pwdCrypt == item.password;
      // return userName == item.username && password == item.password;
    // } );


    // if ( data.username.length == 0 || data.password.length == 0 ) {
    //     Alert.alert('Wroning Input!', 'Username or password field cannot be empty.', [
    //       {text: 'Okay'}
    //     ]);
    //     return;
    //   }

        // const foundUser = () => {
    //   return accountId == username && pwdCrypt == password;
    // };


        // if ( id !== username || pwd !== password ) {
    //   Alert.alert('ID 또는 PASSWORD 가 동일하지 않습니다.', [
    //     {text: 'Okay'}
    //   ]);
    //   return ;
    // }


    // if( username !== id || password !== pwd ) {
    //   Alert.alert('아이디 또는 비밀번호가 동일하지 않습니다.'), [
    //     {text: 'Okay'}
    //   ]
    //   return;
    // }


    // fetch(`${Url}/userlogin/checkLogin`, {  
    //     method: 'POST',
    //     headers: {
    //       'Accept': 'application/json',
    //       'Content-Type': 'application/json;charset=utf-8',    
    //     }
    //     ,
    //     body: JSON.stringify({   
    //       accountId: id,
    //       pwdCrypt: pwd,
    //       IsLoginSave : false,
    //     })  
    //     } )
    //     .then((response) => response.json())
    //     .then((results) => {    
    //       SetLogins(results)
    //       console.log(results)
    //     })
    //     .catch((error)=>{console.error("error")})


// if ( foundUser.length == 0 ) {
//   Alert.alert('Invalid User!', 'Username or password is incorrenct.', [
//     {text: 'Okay'}
//   ]);
//   return;
// }


      // const LoginToken = String(foundUser[0].userToken);
      // const UserId = foundUser[0].username;

      // try {

      //   await AsyncStorage.setItem('userToken', userToken)
      //   await AsyncStorage.setItem('userName', userName)

      //   await AsyncStorage.multiSet([ ['LoginToken', LoginToken], ['UserId', UserId] ])
      // } catch(e) {
      //   console.log(e);
      // } 

      // console.log( 'set user id: ', UserId );
      // console.log( 'set user token: ', LoginToken ); 