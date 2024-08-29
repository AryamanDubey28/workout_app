import React, { useState, useEffect } from 'react';
import { FaChevronLeft, FaChevronRight, FaUser, FaInfoCircle, FaDollarSign } from 'react-icons/fa';

const Sidebar = ({ onToggle }) => {
    const [isMinimized, setIsMinimized] = useState(false);
    const [isMobile, setIsMobile] = useState(window.innerWidth <= 768);

    useEffect(() => {
        const handleResize = () => {
            setIsMobile(window.innerWidth <= 768);
        };

        window.addEventListener('resize', handleResize);
        return () => window.removeEventListener('resize', handleResize);
    }, []);

    const toggleSidebar = () => {
        setIsMinimized(!isMinimized);
        onToggle(!isMinimized);
    };

    const renderMenuItems = () => (
        <>
            <div style={styles.menuItem}>
                <FaDollarSign style={styles.icon} />
                {!isMinimized && <span>Pricing</span>}
            </div>
            <div style={styles.menuItem}>
                <FaUser style={styles.icon} />
                {!isMinimized && <span>Profile</span>}
            </div>
            <div style={styles.menuItem}>
                <FaInfoCircle style={styles.icon} />
                {!isMinimized && <span>About</span>}
            </div>
        </>
    );

    if (isMobile) {
        return (
            <div style={styles.mobileMenu}>
                {renderMenuItems()}
            </div>
        );
    }

    return (
        <div style={{ ...styles.sidebar, width: isMinimized ? '80px' : '250px' }}>
            <div style={styles.logo}>
                {!isMinimized && <h2>Thrive Health</h2>}
            </div>
            <div style={styles.toggleButton} onClick={toggleSidebar}>
                {isMinimized ? <FaChevronRight /> : <FaChevronLeft />}
            </div>
            <div style={styles.menu}>
                {renderMenuItems()}
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
    mobileMenu: {
        display: 'flex',
        justifyContent: 'space-around',
        alignItems: 'center',
        backgroundColor: '#2c3e50',
        color: '#ecf0f1',
        padding: '10px',
        position: 'fixed',
        top: 0,
        left: 0,
        right: 0,
        zIndex: 1000,
    },
};

export default Sidebar;