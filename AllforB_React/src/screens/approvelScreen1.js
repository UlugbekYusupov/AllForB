import * as React from 'react';
import { StyleSheet, View, Text, Button, } from 'react-native';



const ApprovelScreen1 = ({navigation}) => {
  return (
    <View style={styles.container}>
      <Text style={{color: '#F2AA4C'}}>Approvel Screen1</Text>
      <Button  style={styles.button}
        title="click Here"
        onPress={() => alert('Button Clicked!')}
      />
    </View>
  );
}

export default ApprovelScreen1;

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center',
        backgroundColor: '#101820',
    },
    button: {
      color: '#F2AA4C'
    }
});
