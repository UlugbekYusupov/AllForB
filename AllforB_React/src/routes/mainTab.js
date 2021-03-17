import * as React from 'react';
import { StyleSheet, ScrollView, View, Text, } from 'react-native';
// import { createStackNavigator } from '@react-navigation/stack';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import OfficeDrawer from '../routes/officeDrawer';
import ApprovelDrawer from '../routes/approvelDrawer';
import Ionicons from 'react-native-vector-icons/dist/Ionicons';
import FontAwesome from 'react-native-vector-icons/dist/FontAwesome';


const TabBarIcon = (focused, name) => {
  // let iconImagePath;
  let iconName, iconSize;

  if (name==='OfficeDrawer') {
      iconName = 'building'
  } else if (name==='ApprovelDrawer') {
      iconName = 'file-text'
  }

  iconSize = focused ? 30 : 20
  return (
       <FontAwesome 
          name={iconName}
          size={iconSize}
          color={'#F2AA4C'}
      />
  )
}

const Tab = createBottomTabNavigator();
const MainTab = () => {
    
    return (
        <Tab.Navigator 
            initialRouteName = "mainTab"
            tabBarOptions={{

                activeBackgroundColor: '#101820',
                activeTintColor: '#F2AA4C',
                inactiveTintColor: '#F2AA4C',
                style: {
                    borderTopColor: '#F2AA4C',
                    borderTopWidth: 1,
                    backgroundColor: '#1c2229',
                    // marginTop: 30,
                    // height: 60,
                },
                labelPosition: 'beside-icon',
                labelStyle: {
                    fontSize: 15,
                    alignItems: 'center',
                    justifyContent: 'center',
                }
            }}
            screenOptions={({route})=>({
                tabBarLabel: route.name,
                tabBarIcon: ({focused}) => (
                    TabBarIcon (focused, route.name)
                )
            })}          
        >

            <Tab.Screen name="OfficeDrawer" component={OfficeDrawer} options={{ tabBarLabel: '출퇴근',  }} />
            {/* <Tab.Screen name="ApprovelDrawer" component={ApprovelDrawer} options={{ tabBarLabel: '전자결재', }} /> */}
        </Tab.Navigator>
    );
};

const styles = StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: '#fff',
      alignItems: 'center',
      justifyContent: 'center',
    },
});

export default MainTab;
