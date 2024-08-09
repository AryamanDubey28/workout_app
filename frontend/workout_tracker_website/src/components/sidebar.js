import React from 'react';
import { FaDumbbell, FaAppleAlt, FaRegSmile } from 'react-icons/fa'; // Importing icons from react-icons

const Sidebar = () => {
    return (
        <div style={styles.sidebar}>
            <div style={styles.logo}>
                <h2>Health App</h2>
            </div>
            <div style={styles.menu}>
                <div style={styles.menuItem}>
                    <FaDumbbell style={styles.icon} />
                    <span>Workout</span>
                </div>
                <div style={styles.menuItem}>
                    <FaAppleAlt style={styles.icon} />
                    <span>Food Tracking</span>
                </div>
                <div style={styles.menuItem}>
                    <FaRegSmile style={styles.icon} />
                    <span>Stress Tracking</span>
                </div>
            </div>
        </div>
    );
};

const styles = {
    sidebar: {
        height: '100vh',
        width: '250px',
        backgroundColor: '#2c3e50',
        color: '#ecf0f1',
        display: 'flex',
        flexDirection: 'column',
        padding: '20px'
    },
    logo: {
        marginBottom: '30px',
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
    },
};

export default Sidebar;