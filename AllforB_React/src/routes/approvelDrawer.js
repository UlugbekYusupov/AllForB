import * as React from 'react';
// import { StyleSheet, ScrollView, View, Text } from 'react-native';
// import { createStackNavigator } from '@react-navigation/stack';
import { createDrawerNavigator } from '@react-navigation/drawer';
import { HomeStack } from '../routes/foundationStack';
import { ProfilesStack } from '../routes/foundationStack';
import { SettingsStack } from '../routes/foundationStack';
import { ApprovelStack1 } from '../routes/approvelStack';
import { ApprovelStack2 } from '../routes/approvelStack';
import { ApprovelContent } from '../buttons/approvalContent';



const Approvel_Drawer = createDrawerNavigator();
const ApprovelDrawer = ({ navigation }) => {
    
    return (
        <Approvel_Drawer.Navigator
            drawerContent={(props) => <ApprovelContent {...props}/>}
            initialRouteName="HomeDrawer"
        >
            {/* from FoundationStack */}
            <Approvel_Drawer.Screen name="HomeDrawer" component={HomeStack} />
            <Approvel_Drawer.Screen name="ProfilesDrawer" component={ProfilesStack} />   
            <Approvel_Drawer.Screen name="SettingsDrawer" component={SettingsStack} />

            {/* from ApprovelStack */}
            <Approvel_Drawer.Screen name="ApprovelDrawer1" component={ApprovelStack1} />
            <Approvel_Drawer.Screen name="ApprovelDrawer2" component={ApprovelStack2} />   
        </Approvel_Drawer.Navigator>
    );
}

export default ApprovelDrawer;