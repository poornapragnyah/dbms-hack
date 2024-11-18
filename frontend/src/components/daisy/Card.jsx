import React from 'react'

const Card = (props) => {
  return (
    <div className='inline-block m-3'>
        <div className="card bg-base-100 w-96 shadow-xl">
  <figure>
    <img
      src="/inderscience.jpg"
      alt="inderscience" />
  </figure>
  <div className="card-body">
    <h2 className="card-title">{props.title}</h2>
    <p>{props.desc}</p>
    <div className="card-actions justify-end">
      <button className="btn bg-[#2fbabf] text-white">Go To Page</button>
    </div>
  </div>
</div>
    </div>
  )
}

export default Card