import * as React from 'react';
import { StyleSheet, View, Text, Button, } from 'react-native';



const ApprovelScreen2 = ({navigation}) => {
  return (
    <View style={styles.container}>
      <Text style={{color: '#F2AA4C'}}>Approvel Screen2</Text>
      <Button  
        title="click Here"
        onPress={() => alert('Button Clicked!')}
      />
    </View>
  );
}

export default ApprovelScreen2;

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center',
        backgroundColor: '#101820',
    },
});
