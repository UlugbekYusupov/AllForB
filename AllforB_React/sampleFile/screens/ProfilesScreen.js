import * as React from 'react';
import { StyleSheet, View, Text, Button, } from 'react-native';


const ProfileScreen = ({navigation}) => {
  return (
    <View style={styles.container}>
      <Text>Profile Screen</Text>
      <Button  
        title="click Here"
        onPress={() => alert('Button Clicked!')}
      />
    </View>
  );
}

export default ProfileScreen;

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center',
    },
});
