import React, { useState } from 'react';
import { FaDumbbell, FaAppleAlt, FaRegSmile, FaChevronLeft, FaChevronRight } from 'react-icons/fa';

const Sidebar = ({ onToggle }) => {
    const [isMinimized, setIsMinimized] = useState(false);

    const toggleSidebar = () => {
        setIsMinimized(!isMinimized);
        onToggle(!isMinimized); // Pass the updated state to the parent component
    };

    return (
        <div style={{ ...styles.sidebar, width: isMinimized ? '80px' : '250px' }}>
            <div style={styles.logo}>
                {!isMinimized && <h2>Health App</h2>}
            </div>
            <div style={styles.toggleButton} onClick={toggleSidebar}>
                {isMinimized ? <FaChevronRight /> : <FaChevronLeft />}
            </div>
            <div style={styles.menu}>
                <div style={styles.menuItem}>
                    <FaDumbbell style={styles.icon} />
                    {!isMinimized && <span>Workout</span>}
                </div>
                <div style={styles.menuItem}>
                    <FaAppleAlt style={styles.icon} />
                    {!isMinimized && <span>Food Tracking</span>}
                </div>
                <div style={styles.menuItem}>
                    <FaRegSmile style={styles.icon} />
                    {!isMinimized && <span>Stress Tracking</span>}
                </div>
            </div>
        </div>
    );
};

const styles = {
    sidebar: {
        height: '100vh',
        backgroundColor: '#2c3e50',
        color: '#ecf0f1',
        display: 'flex',
        flexDirection: 'column',
        padding: '20px',
        transition: 'width 0.3s ease',
        position: 'fixed', // Make sure the sidebar stays fixed on the page
        top: 0,
        left: 0,
    },
    logo: {
        marginBottom: '20px',
        textAlign: 'center',
    },
    menu: {
        flex: 1,
    },
    menuItem: {
        display: 'flex',
        alignItems: 'center',
        padding: '15px 0',
        cursor: 'pointer',
        borderBottom: '1px solid #34495e',
    },
    icon: {
        marginRight: '15px',
        fontSize: '20px',
    },
    toggleButton: {
        cursor: 'pointer',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        padding: '10px',
        borderBottom: '1px solid #34495e',
        marginBottom: '20px',
    },
};

export default Sidebar;