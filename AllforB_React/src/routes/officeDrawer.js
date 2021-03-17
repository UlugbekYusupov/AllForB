import * as React from 'react';
// import { StyleSheet, ScrollView, View, Text } from 'react-native';
// import { createStackNavigator } from '@react-navigation/stack';
import { createDrawerNavigator } from '@react-navigation/drawer';
import { HomeStack } from '../routes/foundationStack';
import { ProfilesStack } from '../routes/foundationStack';
import { SettingsStack } from '../routes/foundationStack';
import { RecorderStack } from '../routes/officeStack';
import { CheckerStack } from '../routes/officeStack';
import { QrStack } from '../routes/officeStack';
import { OfficeContent } from '../buttons/officeContent';



const Office_Drawer = createDrawerNavigator();
const OfficeDrawer = ({ navigation }) => {
    
    return (
        <Office_Drawer.Navigator
            drawerContent={(props) => <OfficeContent {...props}/>}
            initialRouteName="CheckerDrawer"
        >
            {/* from FoundationStack */}
            <Office_Drawer.Screen name="HomeDrawer" component={HomeStack} />
            <Office_Drawer.Screen name="ProfilesDrawer" component={ProfilesStack} />   
            <Office_Drawer.Screen name="SettingsDrawer" component={SettingsStack} />

            {/* from OfficeStack */}
            <Office_Drawer.Screen name="RecorderDrawer" component={RecorderStack} />  
            <Office_Drawer.Screen name="CheckerDrawer" component={QrStack} />
            <Office_Drawer.Screen name="QrDrawer" component={CheckerStack} />
        </Office_Drawer.Navigator>
    );
}

export default OfficeDrawer;