import * as React from 'react';
import { StyleSheet, ScrollView, View, Button, Image } from 'react-native';
import { DrawerContentScrollView, DrawerItem } from '@react-navigation/drawer';
import { Avatar, Title, Caption, Paragraph, Drawer, Text, TouchableRipple, Switch } from 'react-native-paper';
import Ionicons from 'react-native-vector-icons/dist/Ionicons';
// import FontAwesome from 'react-native-vector-icons/FontAwesome';
import { AuthContext } from '../contexts/context';

const SignoutButton = () => {

    const { signOut } = React.useContext(AuthContext)

    return (
        // <View>
            <Drawer.Section style={{borderTopColor: '#F2AA4C', borderTopWidth: 1, }}>
                <DrawerItem style={styles.bottomDrawerSection}
                    icon={({color, size}) => (
                        <Ionicons
                            name="log-out"
                            color={'#F2AA4C'}
                            size={size}
                        />
                    )}
                    label="Sign Out" 
                    labelStyle={{color: '#F2AA4c'}}
                    onPress={() => {signOut()}}        
                />
            </Drawer.Section>
        // </View>
    );
}

const styles = StyleSheet.create({
    drawerContent: {
        flex: 1,
    },
    bottomDrawerSection: {
        marginLeft: 40,
        fontWeight: 'bold',
    },
})

export default SignoutButton;
