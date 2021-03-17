import React from 'react';
import { Text, View, StyleSheet, Image, TouchableOpacity } from 'react-native';
import { useNavigation, useRoute } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import { createDrawerNavigator, useIsDrawerOpen  } from '@react-navigation/drawer';
import MenuButton from '../buttons/menuButton';


const Stack = createStackNavigator();
const Drawer = createDrawerNavigator();

const MainHeader = () => {

  const navigation = useNavigation();

  return (
    <View style={styles.directionView}>
      <MenuButton />
      <Text style={styles.headerText}>All For B</Text>  
    </View>
  )
}

const styles = StyleSheet.create({
    directionView: {
      flexDirection: 'row',
    },
    iconStyle: {
      alignSelf: 'flex-start',
      width: 35, 
      height: 30,  
      marginTop: 20, 
      marginLeft: 10, 
    },
    headerText: {
      alignSelf: 'center',
      // paddingRight: '23%',
      paddingRight: '12%',
      marginBottom: '1%',
      backgroundColor: 'blue',
      color: 'white',
      width: '100%',
      height: 37,
      fontSize: 35,
      fontWeight: "bold",
      textAlign: 'center',
    },
  })

export default MainHeader;