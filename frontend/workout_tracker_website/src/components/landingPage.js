import React, { useState } from 'react';
import Sidebar from './sidebar';
import Hero from './hero';

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
                    marginLeft: isSidebarMinimized ? '80px' : '250px',
                }}
            >
                <Hero />
                <div style={styles.description}>
                    <p>Cross Platform App and Companion Website for workout, food and stress management aimed to be a holistic platform to track and improve general wellbeing.</p>
                </div>
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
        padding: '0',
        backgroundColor: '#ffffff',
        color: '#333333',
        transition: 'margin-left 0.3s',
    },
    description: {
        maxWidth: '800px',
        margin: '0 auto',
        padding: '40px 20px',
        textAlign: 'center',
        lineHeight: '1.6',
    },
};

export default LandingPage;