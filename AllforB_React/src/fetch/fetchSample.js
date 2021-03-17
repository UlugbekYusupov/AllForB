  

  // fetch('http://112.216.225.178:44362/api/userlogin/checkLogin', {  

    fetch(`${Url}/userlogin/checkLogin`, {  
        method: 'POST',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json;charset=utf-8'    
        }
        ,
        // body: JSON.stringify({
        //   userName,
        //   password
          // password,
        // }) 
        body: JSON.stringify({
          accountId: data.username,
          pwdCrypt: data.password,
        })  
         } )
         .then((response) => response.json())
         .then((response) => {
          //  saveData(response.ReturnCode, response.ExpireDateTime)
      
           saveData(response.ReturnCode)
          // saveData(response.userId)
      
          // saveData(response.loginToken)
          // saveData(response.ExceptionMessage)
          //  saveData(response.ExpireDateTime)
          
          
      
          
          
      
          //  console.log(response.userId)
          //  console.log(response.loginToken)
         })
      .catch((error)=>{console.error("error")})
      
      
      const saveData = async (ReturnCode) => {
      
        await AsyncStorage.setItem("ReturnCode", JSON.stringify(ReturnCode) )
        // await AsyncStorage.setItem("UserId", userId)
      
      
        // await AsyncStorage.setItem("LoginToken", loginToken)
        // await AsyncStorage.setItem("ExceptionMessage", ExceptionMessage)
        // await AsyncStorage.setItem('ExpireDateTime', ExpireDateTime)  
        
      
        // await AsyncStorage.setItem("ReturnCode", ReturnCode, "ExpireDateTime", ExpireDateTime)
        // console.log(AsyncStorage.getItem.ReturnCode)
        // console.log(AsyncStorage.getItem.loginToken)
      }
      
      
      
      AsyncStorage.getItem('ReturnCode', (err, result) => {
        console.log(result); // User1 출력
      });
      
      
      
      
      // const userlogin = async (props)=>{
      //   fetch(`${Url}/userlogin/checkLogin`, {
      //     method:"POST",
      //     headers: {
      //      'Accept': 'application/json',
      //      'Content-Type': 'application/json;charset=utf-8' 
      //    },
      //    body:JSON.stringify({
      //     accountId: data.username,
      //     pwdCrypt: data.password,
      //    })
      //   })
      //   .then(response => response.json())
      //   .then( async (data) => {
      //          try {
      //            await AsyncStorage.setItem('password', data.password)
      //            console.log(data)
      //           //  props.navigation.replace("home")
      //          } catch (e) {
      //            console.log("error hai",e)
      //          }
      //   })
      // }
      
      // useEffect(()=>{
      //   userlogin()
      // },[])
      
      
      
        // fetch(`https://api.openweathermap.org/data/2.5/weather?q=${MyCity}&APPID=343f6f43dfgg979439003b0&units=metric`)
        //    .then(data=>data.json())
        //    .then(results=>{
        //       setInfo({
        //           name:results.name,
        //           temp:results.main.temp,
        //           humidity:results.main.humidity,
        //           desc:results.weather[0].description,
        //           icon:results.weather[0].icon,
        //       })
        //    })
        //    .catch(err=>{
        //        alert(err.message)
        //    })
        //   }
      
      // const saveData = async (json) => {
      //   await AsyncStorage.setItem(item, json)
      //   console.log(item);
        // console.log(json.data.username);
        // console.log(data);
        // console.log(json);
      // }
      // console.log(item.username);
      // console.log(saveData);
      
      
      // console.log(json.data);
      
          // .then((response) => {
          //   console.log('*******************************************************');
          //   console.log(response);
          //   // return json.movies;
          // })
          // .catch((error) => {
          //   console.log('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
          //   console.log(error);
          // });
      
      
          // const saveData = async (data.username) => {
          //   await AsyncStorage.setItem('itemName' , data.username)
          // };
      
      
          
          // const saveData = async (json) => {
          //   await setData({
          //     ...data,
          //     itemName: data.username,
          //   });
      
            // console.log(data.usernaem);
            // console.log(saveData);
            // console.log(itemName);
          // }
      
          // console.log(saveData);
          // console.log(data.usernaem);
          // console.log(itemName);