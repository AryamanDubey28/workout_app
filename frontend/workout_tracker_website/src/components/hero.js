import React from 'react';

const Hero = () => {
    return (
        <div style={styles.hero}>
            <h1 style={styles.title}>Thrive Health</h1>
        </div>
    );
};

const styles = {
    hero: {
        backgroundColor: '#3498db',
        color: '#ffffff',
        padding: '100px 0',
        textAlign: 'center',
    },
    title: {
        fontSize: '48px',
        fontWeight: 'bold',
        margin: '0',
    },
};

export default Hero;