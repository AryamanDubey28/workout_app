import React, { useState } from 'react';
import Sidebar from './sidebar';

const LandingPage = () => {
    const [isSidebarMinimized, setIsSidebarMinimized] = useState(false);

    const handleSidebarToggle = (isMinimized) => {
        setIsSidebarMinimized(isMinimized);
    };

    return (
        <div style={styles.container}>
            <Sidebar onToggle={handleSidebarToggle} />
            <div
                style={{
                    ...styles.content,
                    marginLeft: isSidebarMinimized ? '80px' : '250px', // Adjust margin based on sidebar width
                    textAlign: 'center', // Center the text horizontally
                }}
            >
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
        transition: 'margin-left 0.3s', // Smooth transition for content when sidebar is toggled
    },
};

export default LandingPage;