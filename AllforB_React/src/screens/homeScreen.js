import * as React from 'react';
import { StyleSheet, ScrollView, View, Text, Image } from 'react-native';
// import MainHeaderMenu from '../headers/mainHeaderMenu'
import MainLogo from '../assets/mainLogo';


const Home = () => {
  
  return (
    <View style={{flex:1, backgroundColor: '#101820'}}>

        <View style={{marginTop: 10, alignItems: 'center', }}>
          <Image
            source={require('../assets/Logo_Orange.png')}
            style={styles.logo}
          />
        </View>
        <View style={styles.bodyView}>
            <Text style={styles.text} > Home </Text>
        </View>
    </View>
  );
};

export default Home;

const styles = StyleSheet.create({
  headerView: {
    flex:0.7, 
    backgroundColor: 'blue', 
    justifyContent: 'center',
  },
  bodyView: {
    flex:9.3, 
    backgroundColor: '#101820', 
    alignItems: 'center',
    justifyContent: 'center', 
  },
  text: {
    fontSize: 50,
    fontWeight: 'bold',
    textAlign: 'center',
    color: '#F2AA4C'
  },
  logo: {
    
    width: 350,
    //height: 100
  }
});
