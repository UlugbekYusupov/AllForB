import * as React from 'react';
import { StyleSheet, ScrollView, View, Text, Button, } from 'react-native';
import { createStackNavigator } from '@react-navigation/stack';
import { createMaterialBottomTabNavigator } from '@react-navigation/material-bottom-tabs';
import Icon from 'react-native-vector-icons/dist/Ionicons';
import HomeScreen from '../../sampleFile/screens/HomeScreen';
import DetailsScreen from '../../sampleFile/screens/DetailsScreen';
import ExploreScreen from '../../sampleFile/screens/ExploreScreen';
import ProfilesScreen from '../../sampleFile/screens/ProfilesScreen';

const Tab = createMaterialBottomTabNavigator();
const HomeStack = createStackNavigator();
const DetailsStack = createStackNavigator();


const MainTabScreen = () => (
<Tab.Navigator
      initialRouteName="Home"
      activeColor="#fff"
    >
      <Tab.Screen
        name="Home"
        component={HomeStackScreen}
        options={{
          tabBarLabel: 'Home',
          tabBarColor: '#009387',
          tabBarIcon: ({ color }) => (
            <Icon name="ios-home" color={color} size={26} />
          ),
        }}
      />
      <Tab.Screen
        name="Notifications"
        component={DetailsStackScreen}
        options={{
          tabBarLabel: 'Updates',
          tabBarColor: '#1f65ff',
          tabBarIcon: ({ color }) => (
            <Icon name="ios-notifications" color={color} size={26} />
          ),
        }}
      />
      <Tab.Screen
        name="Profile"
        component={ProfilesScreen}
        options={{
          tabBarLabel: 'Profile',
          tabBarColor: '#694fad',
          tabBarIcon: ({ color }) => (
            <Icon name="person" color={color} size={26} />
          ),
        }}
      />
      <Tab.Screen
        name="Explore"
        component={ExploreScreen}
        options={{
          tabBarLabel: 'Explore',
          tabBarColor: '#d02860',
          tabBarIcon: ({ color }) => (
            <Icon name="ios-aperture" color={color} size={26} />
          ),
        }}
      />
    </Tab.Navigator>
);

export default MainTabScreen;

// HomeStackScreen로 재변경 필요
const HomeStackScreen = ({navigation}) => (
    <HomeStack.Navigator
      screenOptions={{
        headerStyle: {
          backgroundColor: '#009387',
        },
        headerTintColor: '#fff',
        headerTitleStyle: {
          fontWeight: 'bold',
        },
      }}
    >
      <HomeStack.Screen name="Home" component={HomeScreen} 
          options={{ 
            title: 'Overview',
            headerLeft: () => (
              <Icon.Button name="ios-menu" size={25} backgroundColor="#009387" onPress={() => navigation.openDrawer()} />
            )
        }} 
      />
    </HomeStack.Navigator>
  );
  
//   DetailsStackScreen로 재변경 필요
  const DetailsStackScreen = ({navigation}) => (
    <DetailsStack.Navigator
      screenOptions={{
        headerStyle: {
          backgroundColor: '#1f65ff',
        },
        headerTintColor: '#fff',
        headerTitleStyle: {
          fontWeight: 'bold',
        },
      }}
    >
      <DetailsStack.Screen name="Details" component={DetailsScreen} 
        options={{ 
          title: 'Overview',
          headerLeft: () => (
            <Icon.Button name="ios-menu" size={25} backgroundColor="#1f65ff" onPress={() => navigation.openDrawer()} />
          )
        }}
      />
    </DetailsStack.Navigator>
  );
  