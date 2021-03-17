import * as React from 'react';
import { StyleSheet, ScrollView, View, Text, } from 'react-native';
// import MainHeaderMenu from '../headers/mainHeaderMenu';

const Setting = () => {
  
  return (
    <View style={{flex:1, }}>
        {/* <View style={styles.headerView}>
            <MainHeaderMenu />
        </View> */}
        <View style={styles.bodyView}>
            <Text style={styles.text} > Setting </Text>
        </View>        
    </View>
  );
};

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
  }
});

export default Setting;