import React from 'react';
import Sidebar from './sidebar';

const LandingPage = () => {
    return (
        <div style={styles.container}>
            <Sidebar />
            <div style={styles.content}>
                <h1>Welcome to the Health App</h1>
                <p>Select an option from the sidebar to get started.</p>
            </div>
        </div>
    );
};

const styles = {
    container: {
        display: 'flex',
    },
    content: {
        flex: 1,
        padding: '50px',
        backgroundColor: '#ecf0f1',
        color: '#2c3e50',
    },
};

export default LandingPage;