import React from 'react';

function Layout({children}:{children:React.ReactNode}) {
  return (
    <>
      <nav>
        <w3m-button />
      </nav>
      {children}
    </>
  );
}

export default Layout;
