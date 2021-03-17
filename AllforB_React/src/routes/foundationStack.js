import * as React from 'react';
import { StyleSheet, ScrollView, View, Text, } from 'react-native';
import { createStackNavigator } from '@react-navigation/stack';
import HomeScreen from '../screens/homeScreen';
import ProfilesScreen from '../screens/profilesScreen';
import SettingsScreen from '../screens/settingsScreen';
import Menu from '../buttons/menu';


const Home_Stack = createStackNavigator();
export const HomeStack = ({ navigation }) => {
    
    return (
        <Home_Stack.Navigator
          screenOptions={{
            headerStyle:{
            backgroundColor: '#101820',
            borderBottomColor: '#F2AA4C',
            borderBottomWidth: 1
          },
          headerTintColor: '#F2AA4C',
          headerTitleStyle: {
            fontWeight: 'bold',
            fontSize: 25,
          }
        }}
        >
          <Home_Stack.Screen 
            name="HomeStack" 
            component={HomeScreen} 
            options={{
              title: 'ALL For B',
              headerTitleAlign: 'center',
              // headerShown: false,
              headerLeft: () => (<Menu />)
            }}
          />
        </Home_Stack.Navigator>
    );
};


const Profiles_Stack = createStackNavigator();
export const ProfilesStack = ({ navigation }) => {
    
    return (
        <Profiles_Stack.Navigator
          screenOptions={{
            headerStyle:{
            backgroundColor: '#101820',
            borderBottomColor: '#F2AA4C',
            borderBottomWidth: 1
          },
            headerTintColor: '#F2AA4C',
            headerTitleStyle: {
              fontWeight: 'bold',
              fontSize: 25,
            }
          }}
        >
          <Profiles_Stack.Screen 
            name="ProfilesStack" 
            component={ProfilesScreen}
            options={{
              title: '사용자 프로필',
              headerTitleAlign: 'center',
              // headerShown: false,
              headerLeft: () => (<Menu />)
            }} 
          />
        </Profiles_Stack.Navigator>
    );
};


const Settings_Stack = createStackNavigator();
export const SettingsStack = ({ navigation }) => {
    
    return (
        <Settings_Stack.Navigator
          screenOptions={{
            headerStyle:{
            backgroundColor: '#101820',
            borderBottomColor: '#F2AA4C',
            borderBottomWidth: 1
          },
              headerTintColor: '#F2AA4C',
              headerTitleStyle: {
              fontWeight: 'bold',
              fontSize: 25,
            }
          }}
        >
          <Settings_Stack.Screen 
            name="SettingsStack" 
            component={SettingsScreen} 
            options={{
              title: '설정',
              headerTitleAlign: 'center',
              // headerShown: false,
              headerLeft: () => (<Menu />)
            }}
          />
        </Settings_Stack.Navigator>
    );
};

// export { HomeStack, ProfilesStack, SettingsStack };