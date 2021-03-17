import React, { useState, useEffect } from 'react';
import { StyleSheet, ScrollView, View, Button, Image } from 'react-native';
import { Avatar, Title, Caption, Paragraph, Drawer, Text, TouchableRipple, Switch } from 'react-native-paper';
import AsyncStorage from '@react-native-community/async-storage';

const ProfileSidemenu = () => {

    const [accountId, setaccountId] = useState();
    const [personName, setPersonName] = useState();
    useEffect( () => {
        setTimeout( async() => {
          // setIsLoading(false);
          let AccountId;
          let PersonName;
            AccountId = null;
            PersonName = null;
            try {
              AccountId = await AsyncStorage.getItem('AccountId')
              PersonName = await AsyncStorage.getItem('PersonName')
              setaccountId(AccountId)
              setPersonName(PersonName)
            } catch(e) {
              console.log(e); 
            }
          console.log( 'get user id:', AccountId)
          console.log( 'get user id:', PersonName)
        }, 1000);
      }, []);

    return (
        <View style={{ flexDirection: 'row', overflow: 'hidden'}}>
            <Image 
                source={require('../assets/cat.jpg')}
                
                style={{borderRadius: 20, width: 70, height: 70,}}
            />
            <View style={{ marginLeft: 15, flexDirection: 'column', }}>
                <Title style={styles.title}>{personName}</Title>
                <Caption style={styles.caption}>{accountId}</Caption>
            </View>
        </View>            
    );
}

// const FollowSidemenu = () => {
//     return (
//         <View style={styles.row}>
//             <View>
//                 <Paragraph style={[styles.paragraph, styles.caption]}>80</Paragraph>
//                 <Caption style={styles.caption}>Following</Caption>
//                 <Paragraph style={styles.caption2}>100</Paragraph>
//                 <Caption  style={styles.caption2}>Follower</Caption>
//             </View>
//         </View>
//     );
// }

const styles = StyleSheet.create({
    drawerContent: {
        flex: 1,
    },
    title: {
        fontSize: 16,
        marginTop: 10,
        fontWeight: 'bold',
        color: '#F2AA4C',
        textAlign: 'center'
    },
    caption: {
        fontSize: 14,
        lineHeight: 14,
        color: '#F2AA4C',
        
    },
    caption2: {
        fontSize: 14,
        lineHeight: 14,
        color: '#F2AA4C'
    },
    row: {
        marginTop: 20,
        flexDirection: 'row',
        alignItems: 'center',
    },
    paragraph: {
        fontWeight: 'bold',
        marginRight: 3,
        
    },
    drawerSection: {
        marginTop: 15,
    },
})

export { ProfileSidemenu }