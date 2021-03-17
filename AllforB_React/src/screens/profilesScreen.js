import React, {useState,useEffect} from 'react';
import { StyleSheet, ScrollView, View, Text, Image } from 'react-native';
// import MainHeaderMenu from '../headers/mainHeaderMenu';
import Data from '../auth/users';
import AsyncStorage from '@react-native-community/async-storage';
import Url from '../api/urlBase';


// const UserData = Data.map((item) => {
//     return (
//         <View key={item.username}>
//             {item.firstName}
//         </View>
//     );
// })


const Profiles = () => {
    //const [Userid, setuserid] = useState();
    const [jobRankCodeName, setJobRankCodeName] = useState();
    const [personName, setPersonName] = useState();
    const [companyName, setCompanyName] = useState();
    const [dutyCodeName, setDutyCodeName] = useState();

    const fetchINfo = () => {

        setTimeout( async() => {
            // setIsLoading(false);
            let userid;
            //let companyid;
              userid = null;
              //companyid = null;
              try {
                userid = await AsyncStorage.getItem('UserId')
                //setuserid(userid = await AsyncStorage.getItem('UserId'))
                //companyid = await AsyncStorage.getItem('companyId')
              } catch(e) {
                console.log(e); 
              }
            console.log( 'get user id:', userid)
            //setuserid(userid)
            //console.log( 'get user companyid:', companyid );      
            //dispatch({ type: 'REGISTER', token: userToken });
            fetch(`${Url}/userinfo/getInfo`,{
                method: 'POST',
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json;charset=utf-8',    
                }
                ,
                body: JSON.stringify({   
                        UserId : userid,
                        CompanyId : '1' 
                })
            }) 
            .then((response) => response.json())
            .then((results) =>{
                console.log(results)
                setJobRankCodeName(results.JobRankCodeName)
                setPersonName(results.PersonName)
                setCompanyName(results.CompanyName)
                setDutyCodeName(results.DutyCodeName)
                SetName(results)
            })
            .catch((error) => {
                console.error(error)
            })
          }, 1000);

          const SetName = async (results) => {
            try {
              await AsyncStorage.setItem('PersonName', JSON.stringify(results.PersonName))
            } catch(e) {
              console.log(e);
            }
            console.log("set PersonName: ", results.PersonName);
            console.log("set ReturnCode : ", results.ReturnCode);
            console.log(results)
          }

}
    
useEffect(()=>
{
    fetchINfo();
}, []
);

  return (
    <View style={{flex:1}}>
        {/* <View style={styles.headerView}>
            <MainHeaderMenu />
        </View> */}
        <View style={styles.container}>
            <View style={styles.cardContainer}>
                <View style={styles.cardImageContainer}>
                    <Image style={styles.cardImage}  
                    //resizeMode={'contain'}
                            source={require('../assets/cat.jpg')}/>
                    {/* <Text style={styles.cardName}>   
                        사용자
                    </Text> */}
                </View>
          
                <View style={{alignItems: 'center',}}>
                    <Text style={styles.cardName}>   
                        {personName}
                    </Text>
                    {/* <View style={{flexDirection: 'row',}}> 
                        <Text style={styles.flname}>   
                            성 : 이
                        </Text>
                        <Text style={styles.flname}>   
                            이름 : 상윤
                        </Text>
                    </View> */}
                </View>
             {/* <View style={{
                 flexDirection: 'row', 
                 justifyContent: 'center',
                 alignItems: 'center',

                 }}>                  */}
                <View style={styles.cardOccupationContainer}> 
                    <Text style={styles.cardOccupation}>   
                        
                        이름  {"\n"}
                        {/* E-mail  {"\n"}
                        T-전화번호  {"\n"}
                        M-전화번호  {"\n"} */}
                        직급  {"\n"}
                        직책  {"\n"}
                        회사명 {"\t"}
                        
                    </Text>
                    <Text style={styles.cardOccupation2}>   
                      
                       :  {personName}{"\n"}
                       {/* :  aaaa@gmail.com{"\n"}
                       :  02-123-4567{"\n"}
                       :  010-1111-1111{"\n"} */}
                       :  {jobRankCodeName}{"\n"}
                       :  {dutyCodeName}{"\n"}
                       :  {companyName}
                        
                    </Text>
                    {/* <Text style={styles.cardOccupation}>   
                        이름 :
                    </Text>
                    <Text style={styles.cardOccupation}>   
                        E-mail :
                    </Text>
                    <Text style={styles.cardOccupation}>
                        T-전화번호 :
                    </Text>
                    <Text style={styles.cardOccupation}>
                        M-전화번호 :
                    </Text>
                    <Text style={styles.cardOccupation}>
                        직급 :
                    </Text>
                    <Text style={styles.cardOccupation}>
                        부서명 :
                    </Text>
                    <Text style={styles.cardOccupation}>
                        회사명 :
                    </Text> */}
                </View>
                <View>
                    <Text style={styles.cardDescription}>  
                        {/* 서울특별시 노원구 중계2.3동 섬밭로 {'\n'}
                        {'\t'}{'\t'}299(실습동 2층 교무실) */}
                    </Text>
                </View>
             {/* </View> */}
            </View>
        </View>   
    </View>
  );
};

const profileCardColor = '#101820';

const styles = StyleSheet.create({
  container: {
      flex: 1,
      justifyContent: 'center',
      alignItems: 'center',
      backgroundColor: '#101820',
      width: '100%',
      height: '100%',
  },
  cardContainer: {
      alignItems: 'center',
      borderColor: '#F2AA4C',
      borderWidth: 3,
      borderStyle: 'solid',
      borderRadius: 30,
      backgroundColor: profileCardColor,
      width: 350,
      height: 500,
  },
  cardImageContainer: {
      alignItems: 'center',
      backgroundColor: 'white',
      borderWidth: 3,
      borderColor: 'black',
      width: 150,
      height: 150,
      borderRadius: 25,
      marginTop: 8,
      paddingTop: 15,
      overflow: 'hidden'
    //   marginLeft: -140,
    //   flexDirection: 'row'
  },
  cardImage: {
      flex: 1,
      width: '100%',
      height: '100%'
  },
  cardName: {
      color: '#F2AA4C',
      fontWeight: 'bold',
      fontSize: 28,
     // borderBottomColor: '#F2AA4C',
     // borderBottomWidth: 1,
      marginBottom: 5,
      marginTop: 5,
      textShadowColor: 'black',      
      textShadowOffset: {            
          height: 2,
          width: 2
      },
      textShadowRadius: 3,
                  
  },
  cardOccupationContainer: { 
      borderColor: '#F2AA4C',
      borderBottomWidth: 3,
      borderTopWidth: 3,
      flexDirection: 'row',
      //alignItems: 'flex-start',
    //   width: 150,
    //   height: 200,
  },
  cardOccupation: {
      fontWeight: 'bold',
      marginTop: 9,
      marginBottom: 1,
      lineHeight: 23,
      color: '#F2AA4C',
      textAlign: 'right',
      fontSize: 20
  },
  cardOccupation2: {
    fontWeight: 'bold',
    marginTop: 8,
    marginBottom: 6,
    lineHeight: 23,
    //flexDirection: 'row'
    color: '#F2AA4C',
    fontSize: 20
},
  cardDescription: {
      //fontStyle: 'bold',
      fontWeight: 'bold',
      marginTop: 10,
      marginRight: 40,
      marginLeft: 40,
      marginBottom: 10,
      fontSize: 15,
      color: '#F2AA4C',
      fontWeight: 'bold'
  },
  flname: {
    fontWeight: 'bold',
    marginTop: 3,
    marginBottom: 3,
    flexDirection: 'row',
    marginRight: 15,
    marginLeft: 15
  }
});

export default Profiles;